class ConnectionsController < ApplicationController
  def index
    @connections = {
      outbound: Connection.where(castable_id: current_user.id),
      inbound: Connection.where(receivable_id: current_user.id)
    }
  end

  def show
    @connection = Connection.find_by(id: params[:id])
  end

  def approve
    @connection = Connection.find_by(id: params[:id])
    authorize @connection

    @connection.update!(approved_at: Time.now)
  end

  def destroy
    @connection = Connection.find_by id: params[:connection_id]
  end
end