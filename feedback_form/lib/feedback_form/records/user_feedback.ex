defmodule FeedbackForm.Records.UserFeedback do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_feedbacks" do
    field :email, :string
    field :feedback, :string
    field :name, :string
    field :rating, :float
    field :subject, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_feedback, attrs) do
    user_feedback
    |> cast(attrs, [:name, :email, :subject, :rating, :feedback])
    |> validate_required([:name, :email, :subject, :rating, :feedback])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
  end
end
