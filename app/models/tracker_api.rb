class TrackerAPI

  def initialize
    @conn = Faraday.new(:url => 'https://www.pivotaltracker.com')
  end

  def projects(token)
    response = @conn.get do |req|
      req.url "/services/v5/projects"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def stories(token,id)
    project_id = id
    response = @conn.get do |req|
      req.url "/services/v5/projects/#{project_id}/stories/"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def project(token, id)
    project_id = id
    response = @conn.get do |req|
      req.url "/services/v5/projects/#{project_id}"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
