module Repository
  def destroy
    raise NotImplementedError, "#{__method__} has not implemented on #{self.class} [Repository]:"
  end

  def fetch_by(option = {})
    raise NotImplementedError, "#{__method__}(#{option.inspect}) has not implemented on #{self.class} [Repository]:"
  end

  def index(filter)
    raise NotImplementedError, "#{__method__}(#{filter.inspect}) has not implemented on #{self.class} [Repository]:"
  end

  def save(options = {})
    raise NotImplementedError, "#{__method__}(#{options.inspect}) has not implemented on #{self.class} [Repository]:"
  end

  def update(attrs_hash)
    raise NotImplementedError, "#{__method__}(#{attrs_hash.inspect}) has not implemented on #{self.class} [Repository]:"
  end
end
