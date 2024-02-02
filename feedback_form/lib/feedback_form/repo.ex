defmodule FeedbackForm.Repo do
  use Ecto.Repo,
    otp_app: :feedback_form,
    adapter: Ecto.Adapters.Postgres
end
