<template>
  <div class="column content-box">
    <woot-button
      color-scheme="success"
      class-names="button--fixed-right-top"
      icon="add-circle"
      @click="openAddPopup()"
    >
      Add intent
    </woot-button>

    <!-- List Agents -->
    <div class="row">
      <div class="small-8 columns with-right-space ">
        <woot-loading-state
          v-if="uiFlags.isFetching"
          :message="$t('AGENT_MGMT.LOADING')"
        />
        <div v-else>
          <p v-if="!intentList.length">
            {{ intentList }}
          </p>
          <table v-else class="woot-table">
            <tbody>
              <tr v-for="(agent, index) in intentList" :key="agent.email">
                <!-- Agent Name + Email -->
                <td>
                  <span class="agent-name">{{ agent.phrase }}</span>
                </td>
                <!-- Agent Role + Verification Status -->
                <td>
                  <span>{{ agent.agent }}</span>
                </td>
                <!-- Actions -->
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <!-- Add Agent -->
    <woot-modal :show.sync="showAddPopup" :on-close="hideAddPopup">
      <add-agent :on-close="hideAddPopup" />
    </woot-modal>
    <!-- Edit Agent -->
    <woot-modal :show.sync="showEditPopup" :on-close="hideEditPopup">
      <edit-agent
        v-if="showEditPopup"
        :id="currentAgent.id"
        :name="currentAgent.name"
        :type="currentAgent.role"
        :email="currentAgent.email"
        :on-close="hideEditPopup"
      />
    </woot-modal>
    <!-- Delete Agent -->
    <woot-delete-modal
      :show.sync="showDeletePopup"
      :on-close="closeDeletePopup"
      :on-confirm="confirmDeletion"
      :title="$t('AGENT_MGMT.DELETE.CONFIRM.TITLE')"
      :message="deleteMessage"
      :confirm-text="deleteConfirmText"
      :reject-text="deleteRejectText"
    />
  </div>
</template>
<script>
import { mapGetters } from 'vuex';
import globalConfigMixin from 'shared/mixins/globalConfigMixin';
import Thumbnail from '../../../../components/widgets/Thumbnail';
import AddAgent from './AddAgent';
import EditAgent from './EditAgent';

export default {
  components: {
    AddAgent,
    EditAgent,
    Thumbnail,
  },
  mixins: [globalConfigMixin],
  data() {
    return {
      loading: {},
      showAddPopup: false,
      showDeletePopup: false,
      showEditPopup: false,
      agentAPI: {
        message: '',
      },
      currentAgent: {},
    };
  },
  computed: {
    ...mapGetters({
      intentList: 'intent/getIntents',
      uiFlags: 'agents/getUIFlags',
      currentUserId: 'getCurrentUserID',
      globalConfig: 'globalConfig/get',
    }),
    deleteConfirmText() {
      return `${this.$t('AGENT_MGMT.DELETE.CONFIRM.YES')} ${
        this.currentAgent.name
      }`;
    },
    deleteRejectText() {
      return `${this.$t('AGENT_MGMT.DELETE.CONFIRM.NO')} ${
        this.currentAgent.name
      }`;
    },
    deleteMessage() {
      return `${this.$t('AGENT_MGMT.DELETE.CONFIRM.MESSAGE')} ${
        this.currentAgent.name
      } ?`;
    },
  },
  mounted() {
    this.$store.dispatch('intent/get');
  },
  methods: {
    showEditAction(agent) {
      return this.currentUserId !== agent.id;
    },
    showDeleteAction(agent) {
      if (this.currentUserId === agent.id) {
        return false;
      }

      if (!agent.confirmed) {
        return true;
      }

      if (agent.role === 'administrator') {
        return this.verifiedAdministrators().length !== 1;
      }
      return true;
    },
    verifiedAdministrators() {
      return this.agentList.filter(
        agent => agent.role === 'administrator' && agent.confirmed
      );
    },
    // Edit Function
    openAddPopup() {
      this.showAddPopup = true;
    },
    hideAddPopup() {
      this.showAddPopup = false;
    },

    // Edit Function
    openEditPopup(agent) {
      this.showEditPopup = true;
      this.currentAgent = agent;
    },
    hideEditPopup() {
      this.showEditPopup = false;
    },

    // Delete Function
    xopenDeletePopup(agent) {
      this.showDeletePopup = true;
      this.currentAgent = agent;
    },
    closeDeletePopup() {
      this.showDeletePopup = false;
    },
    confirmDeletion() {
      this.loading[this.currentAgent.id] = true;
      this.closeDeletePopup();
      this.deleteAgent(this.currentAgent.id);
    },
    async deleteAgent(id) {
      try {
        await this.$store.dispatch('agents/delete', id);
        this.showAlert(this.$t('AGENT_MGMT.DELETE.API.SUCCESS_MESSAGE'));
      } catch (error) {
        this.showAlert(this.$t('AGENT_MGMT.DELETE.API.ERROR_MESSAGE'));
      }
    },
    // Show SnackBar
    showAlert(message) {
      // Reset loading, current selected agent
      this.loading[this.currentAgent.id] = false;
      this.currentAgent = {};
      // Show message
      this.agentAPI.message = message;
      bus.$emit('newToastMessage', message);
    },
  },
};
</script>
