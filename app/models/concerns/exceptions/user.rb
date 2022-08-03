module Exceptions::User
  class Error < StandardError
  end

  class AdminImmutableException < StandardError
  end
end