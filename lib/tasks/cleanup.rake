
namespace :rm do

  desc 'Removes all memberships where their users have already been deleted'
  task memberships_users: :environment do
    membership_orphans = Membership.where.not(user_id: User.all)
    destroy_orphans(membership_orphans, "memberships table - users")

  end

  desc 'Removes all memberships where their projects have already been deleted'
  task memberships_proj: :environment do
    membership_orphans = Membership.where.not(project_id: Project.all)
    destroy_orphans(membership_orphans, "memberships table - projects")
  end

  desc 'Removes all tasks where their projects have been deleted'
  task tasks: :environment do
    task_orphans = Task.where.not(project_id: Project.all)
    destroy_orphans(task_orphans, "tasks table")

  end

  desc 'Removes all comments where their tasks have been deleted'
  task comments: :environment do
    comment_orphans = Comment.where.not(task_id: Task.all)
    destroy_orphans(comment_orphans, "comments table")
  end

  desc 'Sets the user_id of comments to nil if their users have been deleted'
  task user_id_to_nil: :environment do
    comment_missing_user_ids = Comment.where.not(user_id: User.all)
    puts "Looking at #{comment_missing_user_ids.count} files to remove them from comments"
    comment_missing_user_ids.each do |comment|
      if comment.user_id != nil
        puts "User for comment:#{comment.id} is gone, setting user id to nil"
        comment.update(user_id: nil)
      end
    end
  end

  desc 'Removes any tasks with null project_id'
  task tasks_nil: :environment do
    tasks = Task.where(project_id: nil)
    destroy_orphans(tasks, "tasks-null projects")
  end

  desc 'Removes any comments with a null task_id'
  task comments_nil: :environment do
    comments = Comment.where(task_id: nil)
    destroy_orphans(comments, "comments-null tasks")
  end

  desc 'Removes any memberships with a null project_id or user_id'
  task memberships_nil: :environment do
    memberships = Membership.where(project_id: nil)
    memberships << Membership.where(user_id: nil)
    destroy_orphans(memberships, "memberships-null projects or users")
  end

  desc 'Fix orphaned files in memberships and tasks'
    task :orphans => ['rm:memberships_users', 'rm:memberships_proj',
                      'rm:tasks', 'rm:comments', 'rm:user_id_to_nil',
                      'rm:tasks_nil', 'rm:comments_nil', 'rm:memberships_nil',] do

  end
end

def destroy_orphans(orphans, table_name)
  puts "Looking at #{orphans.count} files to remove them from #{table_name}"
  if orphans.first != []
    orphans.each do |orphan|
      orphan.destroy
      puts "Just removed orphan:#{orphan.id} from #{table_name}"
    end
  end

end
