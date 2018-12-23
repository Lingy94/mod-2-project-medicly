class AppointmentsController < ApplicationController
  before_action :find_appointment, only: [:show, :edit, :update, :destroy]

    def index
      @appointments = Appointment.all
    end

    def show
    end

    def new
    end

    def create
      @appointment = Appointment.new(appointment_params)
      if @appointment.valid?
        @appointment.save
        redirect_to appointment_path(@appointment)
      else
        flash[:errors] = @appointment.errors.full_messages
        render :new
      end
    end

    def edit
    end

    def update
      if @appointment.valid?
        @appointment.save
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
      params.require(:appointment).permit(:doctor_id, :patient_id, :appointment_type_id, :note)
    end
end