<template>
  <div class="column content-box">
    <h5>Customer Profile</h5>
    SOON
  </div>
</template>
<script>
import { mapGetters } from 'vuex';
import globalConfigMixin from 'shared/mixins/globalConfigMixin';
import Thumbnail from '../../../../components/widgets/Thumbnail';

export default {
  components: {
    Thumbnail,
  },
  mixins: [globalConfigMixin],
  data() {
    return {
      loading: {},
      input: '',
      mediaType: 'all',
      byMediaflow: 'first',
      checkedCities: ['I want to talk to someone', 'Not sure'],
      cities: [
        'I want to talk to someone',
        'Not sure',
        'Purchase',
        'Unrecognized intent',
      ],
      intent: ['Increase subscription'],
      checkedIntent: ['Increase subscription'],
      showAddPopup: false,
      showDeletePopup: false,
      showEditPopup: false,
      activeName: 'first',
      dialogFormVisible: false,
      num1: 1,
      num2: 1,
      utterances: [
        { value: 'utterance 1', label: 'utterance 1' },
        {
          value: 'utterance 2',
          label: 'utterance 2',
        },
      ],
      utterancesValue: [],
      form: {
        name: '',
        region: '',
        date1: '',
        date2: '',
        delivery: false,
        type: [],
        resource: '',
        desc: '',
      },
      formLabelWidth: '150px',
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
    addIntent(form) {
      this.intent.push(form.name);
      this.checkedIntent.push(form.name);
      this.dialogFormVisible = false;
    },
    handleCheckedCitiesChange(value) {
      let checkedCount = value.length;
      this.checkAll = checkedCount === this.cities.length;
      this.isIndeterminate =
        checkedCount > 0 && checkedCount < this.cities.length;
    },
    handleCheckedIntent(value) {},
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

<style lang="scss">
h4 {
  //text-align: center;
}
.el-checkbox-group {
  display: flex;
  flex-direction: column;
}

.el-select {
  .el-input {
    margin-bottom: 0;
  }

  input {
    margin: 0 !important;
  }
}

.search-intent {
  &.el-input {
    margin-bottom: 20px;
    width: 300px !important;

    input {
      margin: 0 !important;
    }
  }
}

.el-input-number {
  .el-input {
    width: 100% !important;
    margin: 0 !important;
  }

  input {
    margin: 0 !important;
  }
}

.el-form {
  .el-form {
    width: 100% !important;
  }
}

.el-button.add-intent {
  margin-top: 20px;
}

.el-select {
  width: 100%;
}

input[readonly] {
  background-color: white !important;
}
</style>
