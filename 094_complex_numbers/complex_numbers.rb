class ComplexNumber
  include Math

  attr_reader :real, :imaginary

  def initialize(real = 0, imaginary = 0)
    @real = real
    @imaginary = imaginary
  end

  def +(other)
    ComplexNumber.new(real + other.real, imaginary + other.imaginary)
  end

  def -(other)
    ComplexNumber.new(real - other.real, imaginary - other.imaginary)
  end

  def *(other)
    computed_real = (real * other.real - imaginary * other.imaginary)
    computed_imaginary = (imaginary * other.real + real * other.imaginary)
    ComplexNumber.new(computed_real, computed_imaginary)
  end

  def /(other)
    computed_real = (real * other.real + imaginary * other.imaginary) / (other.real**2 + other.imaginary**2).to_f
    computed_imaginary = (imaginary * other.real - real * other.imaginary) / (other.real**2 + other.imaginary**2).to_f
    ComplexNumber.new(computed_real, computed_imaginary)
  end

  def ==(other)
    real == other.real && imaginary == other.imaginary
  end

  def abs
    sqrt(real**2 + imaginary**2)
  end

  def conjugate
    ComplexNumber.new(real, -imaginary)
  end

  def exp
    computed_real = (E**real * cos(imaginary)).round(15)
    computed_imaginary = (E**real * sin(imaginary)).round(15)
    ComplexNumber.new(computed_real, computed_imaginary)
  end
end
