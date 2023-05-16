defmodule CitasAppWeb.CitaController do
  use CitasAppWeb, :controller

  alias CitasApp.Citas
  alias CitasApp.Citas.Cita

  action_fallback CitasAppWeb.FallbackController

  def index(conn, _params) do
    citas = Citas.list_citas()
    render(conn, :index, citas: citas)
  end

  def create(conn, %{"cita" => cita_params}) do
    with {:ok, %Cita{} = cita} <- Citas.create_cita(cita_params) do
      conn
      |> put_status(:created)
      #|> put_resp_header("location", ~p"/api/citas/#{cita}")
      |> render(:show, cita: cita)
    end
  end

  def show(conn, %{"id" => id}) do
    cita = Citas.get_cita!(id)
    render(conn, :show, cita: cita)
  end

  def update(conn, %{"id" => id, "cita" => cita_params}) do
    cita = Citas.get_cita!(id)

    with {:ok, %Cita{} = cita} <- Citas.update_cita(cita, cita_params) do
      render(conn, :show, cita: cita)
    end
  end

  def delete(conn, %{"id" => id}) do
    cita = Citas.get_cita!(id)

    with {:ok, %Cita{}} <- Citas.delete_cita(cita) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_citas_por_diagnostico(conn, %{"diagnostico" => diagnostico}) do
    IO.puts("____________________*****")
    IO.inspect(diagnostico, label: "diagnostico::::::")
    citas = Citas.get_citas_por_diagnostico!(diagnostico)
    IO.inspect(citas, label: "citas::::::")
    render(conn, "citas.json", citas: citas)
  end
end
