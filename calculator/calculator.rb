class Calculator

  #
  # [add Add two numbers]
  # @param a [type] [description]
  # @param b [type] [description]
  #
  # @example
  #   Calculator.new.add(12, 13)
  # @return [type] [description]
  def add(a,b)
    result = a+b
    result
  end

  #
  # [substract description]
  # @param a [type] [description]
  # @param b [type] [description]
  #
  # @example
  #   Calculator.new.substract(13, 1)
  # @return [type] [description]
  def substract(a,b)
    result = a-b
    result
  end


  #
  # [mutiply description]
  # @param a [type] [description]
  # @param b [type] [description]
  # @example
  #   Calculator.new.multiply(12, 13)
  # @return [type] [description]
  def multiply(a,b)
    result = 0
    b.times do
      result = add(result,a)
    end
  end

  #
  # [divide description]
  # @param a [type] [description]
  # @param b [type] [description]
  # @example
  #   Calculator.new.divide(26, 13)
  # @return [type] [description]
  def divide(a,b)
    result = a/b
    result
  end
end
