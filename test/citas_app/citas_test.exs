defmodule CitasApp.CitasTest do
  use CitasApp.DataCase

  alias CitasApp.Citas

  describe "citas" do
    alias CitasApp.Citas.Cita

    import CitasApp.CitasFixtures

    @invalid_attrs %{diagnostico: nil, fecha: nil, medicamentos: nil, sintomas: nil}

    test "list_citas/0 returns all citas" do
      cita = cita_fixture()
      assert Citas.list_citas() == [cita]
    end

    test "get_cita!/1 returns the cita with given id" do
      cita = cita_fixture()
      assert Citas.get_cita!(cita.id) == cita
    end

    test "create_cita/1 with valid data creates a cita" do
      valid_attrs = %{diagnostico: "some diagnostico", fecha: ~D[2023-05-14], medicamentos: "some medicamentos", sintomas: "some sintomas"}

      assert {:ok, %Cita{} = cita} = Citas.create_cita(valid_attrs)
      assert cita.diagnostico == "some diagnostico"
      assert cita.fecha == ~D[2023-05-14]
      assert cita.medicamentos == "some medicamentos"
      assert cita.sintomas == "some sintomas"
    end

    test "create_cita/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Citas.create_cita(@invalid_attrs)
    end

    test "update_cita/2 with valid data updates the cita" do
      cita = cita_fixture()
      update_attrs = %{diagnostico: "some updated diagnostico", fecha: ~D[2023-05-15], medicamentos: "some updated medicamentos", sintomas: "some updated sintomas"}

      assert {:ok, %Cita{} = cita} = Citas.update_cita(cita, update_attrs)
      assert cita.diagnostico == "some updated diagnostico"
      assert cita.fecha == ~D[2023-05-15]
      assert cita.medicamentos == "some updated medicamentos"
      assert cita.sintomas == "some updated sintomas"
    end

    test "update_cita/2 with invalid data returns error changeset" do
      cita = cita_fixture()
      assert {:error, %Ecto.Changeset{}} = Citas.update_cita(cita, @invalid_attrs)
      assert cita == Citas.get_cita!(cita.id)
    end

    test "delete_cita/1 deletes the cita" do
      cita = cita_fixture()
      assert {:ok, %Cita{}} = Citas.delete_cita(cita)
      assert_raise Ecto.NoResultsError, fn -> Citas.get_cita!(cita.id) end
    end

    test "change_cita/1 returns a cita changeset" do
      cita = cita_fixture()
      assert %Ecto.Changeset{} = Citas.change_cita(cita)
    end
  end
end
