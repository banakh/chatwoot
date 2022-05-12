import * as MutationHelpers from 'shared/helpers/vuex/mutationHelpers';
import * as types from '../mutation-types';
import IntentApi from '../../api/intent';

export const state = {
  records: [],
  uiFlags: {
    isFetching: false,
    isCreating: false,
    isUpdating: false,
    isDeleting: false,
  },
};

export const getters = {
  getIntents($state) {
    return $state.records;
  },
  getVerifiedIntents($state) {
    return $state.records.filter(record => record.confirmed);
  },
  getUIFlags($state) {
    return $state.uiFlags;
  },
};

export const actions = {
  get: async ({ commit }) => {
    commit(types.default.SET_INTENT_FETCHING_STATUS, true);
    try {
      const response = await IntentApi.get();
      commit(types.default.SET_INTENT_FETCHING_STATUS, false);
      commit(types.default.SET_INTENTS, response.data);
    } catch (error) {
      commit(types.default.SET_INTENT_FETCHING_STATUS, false);
    }
  },
  create: async ({ commit }, agentInfo) => {
    commit(types.default.SET_INTENT_CREATING_STATUS, true);
    try {
      const response = await IntentApi.create(agentInfo);
      commit(types.default.ADD_INTENT, response.data);
      commit(types.default.SET_INTENT_CREATING_STATUS, false);
    } catch (error) {
      commit(types.default.SET_INTENT_CREATING_STATUS, false);
      throw error;
    }
  },
  update: async ({ commit }, { id, ...agentParams }) => {
    commit(types.default.SET_INTENT_UPDATING_STATUS, true);
    try {
      const response = await IntentApi.update(id, agentParams);
      commit(types.default.EDIT_INTENT, response.data);
      commit(types.default.SET_INTENT_UPDATING_STATUS, false);
    } catch (error) {
      commit(types.default.SET_INTENT_UPDATING_STATUS, false);
      throw new Error(error);
    }
  },

  updatePresence: async ({ commit }, data) => {
    commit(types.default.SET_INTENT_UPDATING_STATUS, true);
    commit(types.default.UPDATE_INTENTS_PRESENCE, data);
    commit(types.default.SET_INTENT_UPDATING_STATUS, false);
  },

  delete: async ({ commit }, agentId) => {
    commit(types.default.SET_INTENT_DELETING_STATUS, true);
    try {
      await IntentApi.delete(agentId);
      commit(types.default.DELETE_INTENT, agentId);
      commit(types.default.SET_INTENT_DELETING_STATUS, false);
    } catch (error) {
      commit(types.default.SET_INTENT_DELETING_STATUS, false);
      throw new Error(error);
    }
  },
};

export const mutations = {
  [types.default.SET_INTENT_FETCHING_STATUS]($state, status) {
    $state.uiFlags.isFetching = status;
  },
  [types.default.SET_INTENT_CREATING_STATUS]($state, status) {
    $state.uiFlags.isCreating = status;
  },
  [types.default.SET_INTENT_UPDATING_STATUS]($state, status) {
    $state.uiFlags.isUpdating = status;
  },
  [types.default.SET_INTENT_DELETING_STATUS]($state, status) {
    $state.uiFlags.isDeleting = status;
  },

  [types.default.SET_INTENTS]: MutationHelpers.set,
  [types.default.ADD_INTENT]: MutationHelpers.create,
  [types.default.EDIT_INTENT]: MutationHelpers.update,
  [types.default.DELETE_INTENT]: MutationHelpers.destroy,
  [types.default.UPDATE_INTENTS_PRESENCE]: MutationHelpers.updatePresence,
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
};
