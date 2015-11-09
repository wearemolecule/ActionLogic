require 'action_logic'
require 'fixtures/tasks'
require 'fixtures/constants'

class SimpleTestUseCase
  include ActionLogic::ActionUseCase

  def call
  end

  def tasks
    [SimpleTestTask]
  end
end

class SimpleTestUseCase2
  include ActionLogic::ActionUseCase

  def call
  end

  def tasks
    [UseCaseTestTask1,
     UseCaseTestTask2]
  end
end

class SimpleTestUseCase3
  include ActionLogic::ActionUseCase

  def call
    context.second = "defined in use case"
  end

  def tasks
    [UseCaseTestTask1]
  end
end

class ValidateBeforeTestUseCase
  include ActionLogic::ActionUseCase

  validates_before Constants::ALL_VALIDATIONS

  def call
  end

  def tasks
    []
  end
end

class ValidateBeforePresenceTestUseCase
  include ActionLogic::ActionUseCase

  validates_before Constants::PRESENCE_VALIDATION

  def call
  end

  def tasks
    []
  end
end

class ValidateBeforeCustomPresenceTestUseCase
  include ActionLogic::ActionUseCase

  validates_before Constants::CUSTOM_PRESENCE_VALIDATION

  def call
  end

  def tasks
    []
  end
end

class ValidateBeforeCustomTypeTestUseCase
  include ActionLogic::ActionUseCase

  validates_before Constants::CUSTOM_TYPE_VALIDATION1

  def call
  end

  def tasks
    []
  end
end

class ValidateBeforeUnrecognizablePresenceTestUseCase
  include ActionLogic::ActionUseCase

  validates_before :integer_test => { :presence => :true }

  def call
  end

  def tasks
    []
  end
end

class ValidateAfterTestUseCase
  include ActionLogic::ActionUseCase

  validates_after Constants::ALL_VALIDATIONS

  def call
    context.integer_test = 1
    context.float_test   = 1.0
    context.string_test  = "string"
    context.bool_test    = false
    context.hash_test    = {}
    context.array_test   = []
    context.symbol_test  = :symbol
    context.nil_test     = nil
  end

  def tasks
    []
  end
end

class ValidateAfterMissingAttributesTestUseCase
  include ActionLogic::ActionUseCase

  validates_after Constants::ALL_VALIDATIONS

  def call
  end

  def tasks
    []
  end
end

class ValidateAfterInvalidTypeTestUseCase
  include ActionLogic::ActionUseCase

  validates_after Constants::ALL_VALIDATIONS

  def call
    context.integer_test = nil
    context.float_test   = nil
    context.string_test  = nil
    context.bool_test    = nil
    context.hash_test    = nil
    context.array_test   = nil
    context.symbol_test  = nil
    context.nil_test     = 1
  end

  def tasks
    []
  end
end

class ValidateAfterCustomTypeTestUseCase
  include ActionLogic::ActionUseCase

  validates_after Constants::CUSTOM_TYPE_VALIDATION1

  def call
    context.custom_type = CustomType1.new
  end

  def tasks
    []
  end
end

class ValidateAfterInvalidCustomTypeTestUseCase
  include ActionLogic::ActionUseCase

  validates_after Constants::CUSTOM_TYPE_VALIDATION2

  def call
    context.custom_type = CustomType1.new
  end

  def tasks
    []
  end
end

class ValidateAfterPresenceTestUseCase
  include ActionLogic::ActionUseCase

  validates_after Constants::PRESENCE_VALIDATION

  def call
    context.integer_test = 1
  end

  def tasks
    []
  end
end

class ValidateAfterInvalidPresenceTestUseCase
  include ActionLogic::ActionUseCase

  validates_after Constants::PRESENCE_VALIDATION

  def call
    context.integer_test = nil
  end

  def tasks
    []
  end
end

class ValidateAfterCustomPresenceTestUseCase
  include ActionLogic::ActionUseCase

  validates_after Constants::CUSTOM_PRESENCE_VALIDATION

  def call
    context.array_test = [1]
  end

  def tasks
    []
  end
end

class ValidateAfterInvalidCustomPresenceTestUseCase
  include ActionLogic::ActionUseCase

  validates_after Constants::CUSTOM_PRESENCE_VALIDATION

  def call
    context.array_test = []
  end

  def tasks
    []
  end
end

class ValidateAfterUnrecognizablePresenceTestUseCase
  include ActionLogic::ActionUseCase

  validates_after :integer_test => { :presence => :true }

  def call
    context.integer_test = 1
  end

  def tasks
    []
  end
end

class FailureTestUseCase
  include ActionLogic::ActionUseCase

  def call
  end

  def tasks
    [UseCaseTestTask1,
     UseCaseTestTask2,
     UseCaseFailureTestTask,
     UseCaseTestTask3]
  end
end

class HaltTestUseCase
  include ActionLogic::ActionUseCase

  def call
  end

  def tasks
    [UseCaseTestTask1,
     UseCaseTestTask2,
     UseCaseHaltTestTask,
     UseCaseTestTask3]
  end
end

class UseCaseTestTask1
  include ActionLogic::ActionTask

  def call
    context.first = "first"
  end
end

class UseCaseTestTask2
  include ActionLogic::ActionTask

  def call
    context.second = "second"
  end
end

class UseCaseTestTask3
  include ActionLogic::ActionTask

  def call
    context.third = "third"
  end
end

class UseCaseFailureTestTask
  include ActionLogic::ActionTask

  def call
    context.fail!(Constants::FAILURE_MESSAGE)
  end
end

class UseCaseHaltTestTask
  include ActionLogic::ActionTask

  def call
    context.halt!(Constants::HALT_MESSAGE)
  end
end
