json.id intent_classifier.id
json.user_id intent_classifier.user_id
json.agent User.find(intent_classifier.user_id).name
json.phrase intent_classifier.phrase
