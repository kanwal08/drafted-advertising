# frozen_string_literal: true

module CallableBehavior
  def call(*args)
    new(*args).call
  end
end
