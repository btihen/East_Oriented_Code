# dhh_test_damage
# https://gist.github.com/dhh/4849a20d2ba89b34b201

# Original Rails controller and action
class EmployeesController < ApplicationController
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to @employee, notice: "Employee #{@employee.name} created"
    else
      render :new
    end
  end
end


# Hexagon-inspired, test-induced, damaged version
class EmployeesController < ApplicationController
  def create
    CreateRunner.new(self, EmployeesRepository.new).run(params[:employee])
  end

  def create_succeeded(employee, message)
    redirect_to employee, notice: message
  end

  def create_failed(employee)
    @employee = employee
    render :new
  end
end

class CreateRunner
  attr_reader :context, :repo

  def initialize(context, repo)
    @context = context
    @repo    = repo
  end

  def run(employee_attrs)
    @employee = repo.new_employee(employee_attrs)

    if repo.save_employee
      context.create_succeeded(employee, "Employee #{employee.name} created")
    else
      context.create_failed(employee)
    end
  end
end

class EmployeesRepository
  def new_employee(*args)
    Biz::Employee.new(Employee.new(*args))
  end

  def save_employee(employee)
    employee.save
  end
end

require 'delegate'

module Biz
  class Employee < SimpleDelegator
    def self.wrap(employees)
      employees.wrap { |e| new(e) }
    end

    def class
      __getobj__.class
    end

    # Biz logic ... AR is only a data-access object
  end
end
