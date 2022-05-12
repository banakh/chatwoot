// eslint-disable-next-line no-unused-vars
/* global axios */
import ApiClient from './ApiClient';

class IntentAPI extends ApiClient {
  constructor() {
    super('intent_classifiers', { accountScoped: true });
  }
}

export default new IntentAPI();
