class RepositoryContainer

  def self.add(type, repository)
    repos[type] = repository
  end

  def self.repos
    @repos ||= {}
  end

  def self.get_repo(type)
    repos[type]
  end
end
