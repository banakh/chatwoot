json.array! @intent_classifiers do |intent_classifier|
  json.partial! 'api/v1/accounts/intent_classifiers/partials/intent_classifier.json.jbuilder', intent_classifier: intent_classifier
end

