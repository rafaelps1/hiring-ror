module Repository
  def index(filter)
    raise NotImplementedError, "#{__method__} has not implemented on Repository"
  end

  def inactive(id)
    raise NotImplementedError, "#{__method__} has not implemented on Repository"
  end
end
