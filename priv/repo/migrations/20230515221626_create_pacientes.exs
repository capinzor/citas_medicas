defmodule CitasApp.Repo.Migrations.CreatePacientes do
  use Ecto.Migration

  def change do
    create table(:pacientes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :num_id, :string
      add :nombres, :string
      add :apellidos, :string
      add :mail, :string
      add :fecha_nac, :date

      timestamps()
    end
    create unique_index(:pacientes, [:num_id])
  end
end
