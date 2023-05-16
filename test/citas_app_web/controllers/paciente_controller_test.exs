defmodule CitasAppWeb.PacienteControllerTest do
  use CitasAppWeb.ConnCase

  import CitasApp.PacientesFixtures

  alias CitasApp.Pacientes.Paciente

  @create_attrs %{
    apellidos: "some apellidos",
    fecha_nac: ~D[2023-05-14],
    mail: "some mail",
    nombres: "some nombres",
    num_id: "some num_id"
  }
  @update_attrs %{
    apellidos: "some updated apellidos",
    fecha_nac: ~D[2023-05-15],
    mail: "some updated mail",
    nombres: "some updated nombres",
    num_id: "some updated num_id"
  }
  @invalid_attrs %{apellidos: nil, fecha_nac: nil, mail: nil, nombres: nil, num_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pacientes", %{conn: conn} do
      conn = get(conn, ~p"/api/pacientes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create paciente" do
    test "renders paciente when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/pacientes", paciente: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/pacientes/#{id}")

      assert %{
               "id" => ^id,
               "apellidos" => "some apellidos",
               "fecha_nac" => "2023-05-14",
               "mail" => "some mail",
               "nombres" => "some nombres",
               "num_id" => "some num_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/pacientes", paciente: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update paciente" do
    setup [:create_paciente]

    test "renders paciente when data is valid", %{conn: conn, paciente: %Paciente{id: id} = paciente} do
      conn = put(conn, ~p"/api/pacientes/#{paciente}", paciente: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/pacientes/#{id}")

      assert %{
               "id" => ^id,
               "apellidos" => "some updated apellidos",
               "fecha_nac" => "2023-05-15",
               "mail" => "some updated mail",
               "nombres" => "some updated nombres",
               "num_id" => "some updated num_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, paciente: paciente} do
      conn = put(conn, ~p"/api/pacientes/#{paciente}", paciente: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete paciente" do
    setup [:create_paciente]

    test "deletes chosen paciente", %{conn: conn, paciente: paciente} do
      conn = delete(conn, ~p"/api/pacientes/#{paciente}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/pacientes/#{paciente}")
      end
    end
  end

  defp create_paciente(_) do
    paciente = paciente_fixture()
    %{paciente: paciente}
  end
end
