defmodule CitasApp.Repo.Migrations.CreateCitas do
  use Ecto.Migration

  def change do
    create table(:citas, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :fecha, :date
      add :sintomas, :string
      add :diagnostico, :string
      add :medicamentos, :string
      add :paciente_id, references(:pacientes, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:citas, [:paciente_id])
  end
end
