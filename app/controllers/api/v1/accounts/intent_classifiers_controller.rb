class Api::V1::Accounts::IntentClassifiersController < Api::V1::Accounts::BaseController
  # before_action :check_authorization
  before_action :fetch_intent_classifier, only: [:show, :update, :destroy]

  def index
    @intent_classifiers = IntentClassifier.all
  end

  def create
    @intent_classifier = IntentClassifier.create(intent_classifier_permit)
  end

  def show; end

  def update
    @intent_classifier.update(intent_classifier_permit)
  end

  def destroy
    @intent_classifier.destroy!
    head :ok
  end

  private

  def intent_classifier_permit
    params.permit(
      :user_id,
      :name,
      :app_id,
      :enabled,
      :phrases => []
    )
  end

  def fetch_intent_classifier
    @intent_classifier = IntentClassifier.find_by(id: params[:id])
  end
end
