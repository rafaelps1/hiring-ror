module Repository
  def destroy
    raise NotImplementedError, "#{__method__} has not implemented on Repository:"
  end

  def fetch_by(option = {})
    raise NotImplementedError, "#{__method__}(#{option.inspect}) has not implemented on Repository:"
  end

  def index(filter)
    raise NotImplementedError, "#{__method__} has not implemented on Repository"
  end
end
