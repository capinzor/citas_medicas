defmodule CitasAppWeb.CitaControllerTest do
  use CitasAppWeb.ConnCase

  import CitasApp.CitasFixtures

  alias CitasApp.Citas.Cita

  @create_attrs %{
    diagnostico: "some diagnostico",
    fecha: ~D[2023-05-14],
    medicamentos: "some medicamentos",
    sintomas: "some sintomas"
  }
  @update_attrs %{
    diagnostico: "some updated diagnostico",
    fecha: ~D[2023-05-15],
    medicamentos: "some updated medicamentos",
    sintomas: "some updated sintomas"
  }
  @invalid_attrs %{diagnostico: nil, fecha: nil, medicamentos: nil, sintomas: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all citas", %{conn: conn} do
      conn = get(conn, ~p"/api/citas")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create cita" do
    test "renders cita when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/citas", cita: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/citas/#{id}")

      assert %{
               "id" => ^id,
               "diagnostico" => "some diagnostico",
               "fecha" => "2023-05-14",
               "medicamentos" => "some medicamentos",
               "sintomas" => "some sintomas"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/citas", cita: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update cita" do
    setup [:create_cita]

    test "renders cita when data is valid", %{conn: conn, cita: %Cita{id: id} = cita} do
      conn = put(conn, ~p"/api/citas/#{cita}", cita: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/citas/#{id}")

      assert %{
               "id" => ^id,
               "diagnostico" => "some updated diagnostico",
               "fecha" => "2023-05-15",
               "medicamentos" => "some updated medicamentos",
               "sintomas" => "some updated sintomas"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, cita: cita} do
      conn = put(conn, ~p"/api/citas/#{cita}", cita: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete cita" do
    setup [:create_cita]

    test "deletes chosen cita", %{conn: conn, cita: cita} do
      conn = delete(conn, ~p"/api/citas/#{cita}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/citas/#{cita}")
      end
    end
  end

  defp create_cita(_) do
    cita = cita_fixture()
    %{cita: cita}
  end
end
