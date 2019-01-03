class AppointmentsController < ApplicationController
  before_action :find_appointment, only: [:show, :edit, :update, :destroy]
  before_action :require_login

    def index
      @appointments = Appointment.all
    end

    def show
      @doctor = @appointment.doctor
    end

    def new
      @appointment = Appointment.new
      @user = current_user
    end

    def create

      @appointment = Appointment.new(appointment_params)
      @user = current_user
      if @appointment.valid?
        @appointment.save(appointment_params)
        redirect_to appointment_path(@appointment)
      else
        flash[:errors] = @appointment.errors.full_messages
        render :new
      end
    end

    def edit
      @user = current_user
    end

    def update
      @user = current_user
      if @appointment.valid?
        @appointment.update(appointment_params)
        redirect_to appointment_path(@appointment)
      else
        flash[:errors] = @appointment.errors.full_messages
        render :new
      end
    end

    def destroy
      @appointment.destroy
      redirect_to appointments_path
    end

  private

    def find_appointment
      @appointment = Appointment.find(params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(:doctor_id, :user_id, :appointment_type_id, :note, :appointment_date)
    end

    def require_login
      redirect_to sessions_new_path unless session.include?(:user_id)
    end
end
