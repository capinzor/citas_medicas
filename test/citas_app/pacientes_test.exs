defmodule CitasApp.PacientesTest do
  use CitasApp.DataCase

  alias CitasApp.Pacientes

  describe "pacientes" do
    alias CitasApp.Pacientes.Paciente

    import CitasApp.PacientesFixtures

    @invalid_attrs %{apellidos: nil, fecha_nac: nil, mail: nil, nombres: nil, num_id: nil}

    test "list_pacientes/0 returns all pacientes" do
      paciente = paciente_fixture()
      assert Pacientes.list_pacientes() == [paciente]
    end

    test "get_paciente!/1 returns the paciente with given id" do
      paciente = paciente_fixture()
      assert Pacientes.get_paciente!(paciente.id) == paciente
    end

    test "create_paciente/1 with valid data creates a paciente" do
      valid_attrs = %{apellidos: "some apellidos", fecha_nac: ~D[2023-05-14], mail: "some mail", nombres: "some nombres", num_id: "some num_id"}

      assert {:ok, %Paciente{} = paciente} = Pacientes.create_paciente(valid_attrs)
      assert paciente.apellidos == "some apellidos"
      assert paciente.fecha_nac == ~D[2023-05-14]
      assert paciente.mail == "some mail"
      assert paciente.nombres == "some nombres"
      assert paciente.num_id == "some num_id"
    end

    test "create_paciente/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pacientes.create_paciente(@invalid_attrs)
    end

    test "update_paciente/2 with valid data updates the paciente" do
      paciente = paciente_fixture()
      update_attrs = %{apellidos: "some updated apellidos", fecha_nac: ~D[2023-05-15], mail: "some updated mail", nombres: "some updated nombres", num_id: "some updated num_id"}

      assert {:ok, %Paciente{} = paciente} = Pacientes.update_paciente(paciente, update_attrs)
      assert paciente.apellidos == "some updated apellidos"
      assert paciente.fecha_nac == ~D[2023-05-15]
      assert paciente.mail == "some updated mail"
      assert paciente.nombres == "some updated nombres"
      assert paciente.num_id == "some updated num_id"
    end

    test "update_paciente/2 with invalid data returns error changeset" do
      paciente = paciente_fixture()
      assert {:error, %Ecto.Changeset{}} = Pacientes.update_paciente(paciente, @invalid_attrs)
      assert paciente == Pacientes.get_paciente!(paciente.id)
    end

    test "delete_paciente/1 deletes the paciente" do
      paciente = paciente_fixture()
      assert {:ok, %Paciente{}} = Pacientes.delete_paciente(paciente)
      assert_raise Ecto.NoResultsError, fn -> Pacientes.get_paciente!(paciente.id) end
    end

    test "change_paciente/1 returns a paciente changeset" do
      paciente = paciente_fixture()
      assert %Ecto.Changeset{} = Pacientes.change_paciente(paciente)
    end
  end
end
