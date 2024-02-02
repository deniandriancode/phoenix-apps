defmodule FeedbackForm.Repo.Migrations.CreateUserFeedbacks do
  use Ecto.Migration

  def change do
    create table(:user_feedbacks) do
      add :name, :string
      add :email, :string
      add :subject, :string
      add :rating, :float
      add :feedback, :text

      timestamps(type: :utc_datetime)
    end
  end
end
