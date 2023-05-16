defmodule CitasAppWeb.PacienteController do
  use CitasAppWeb, :controller

  alias CitasApp.Pacientes
  alias CitasApp.Pacientes.Paciente

  action_fallback CitasAppWeb.FallbackController

  def index(conn, _params) do
    pacientes = Pacientes.list_pacientes()
    render(conn, :index, pacientes: pacientes)
  end

  def create(conn, %{"paciente" => paciente_params}) do
    with {:ok, %Paciente{} = paciente} <- Pacientes.create_paciente(paciente_params) do
      conn
      |> put_status(:created)
      #|> put_resp_header("location", ~p"/api/pacientes/#{paciente}")
      |> render(:show, paciente: paciente)
    end
  end

  def show(conn, %{"id" => id}) do
    paciente = Pacientes.get_paciente!(id)
    render(conn, :show, paciente: paciente)
  end

  def update(conn, %{"id" => id, "paciente" => paciente_params}) do
    paciente = Pacientes.get_paciente!(id)

    with {:ok, %Paciente{} = paciente} <- Pacientes.update_paciente(paciente, paciente_params) do
      render(conn, :show, paciente: paciente)
    end
  end

  def delete(conn, %{"id" => id}) do
    paciente = Pacientes.get_paciente!(id)

    with {:ok, %Paciente{}} <- Pacientes.delete_paciente(paciente) do
      send_resp(conn, :no_content, "")
    end
  end
end
