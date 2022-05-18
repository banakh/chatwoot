<template>
  <div class="agent-admin column content-box">
    <h5>Agent Admin</h5>
    <div class="content-box">
      <div class="small-9 columns with-right-space ">
        <el-table size="mini" :data="agentList" style="width: 100%">
          <el-table-column prop="id" label="ID" width="50"> </el-table-column>
          <el-table-column prop="name" label="Full Name"> </el-table-column>
          <el-table-column prop="email" label="Email"> </el-table-column>
          <el-table-column prop="email" label="Reserved Agent">
          </el-table-column>
          <el-table-column prop="status" label="Status" width="100">
          </el-table-column>
          <el-table-column width="80">
            <template slot-scope="scope">
              <router-link
                :to="
                  addAccountScoping(
                    `sentio-manager/agent-admin/${scope.row.id}`
                  )
                "
                custom
                v-slot="{ navigate }"
              >
                <el-button type="text" size="small" @click="navigate">
                  Details
                </el-button>
              </router-link>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </div>
  </div>
</template>
<script>
import { mapGetters } from 'vuex';
import globalConfigMixin from 'shared/mixins/globalConfigMixin';
import Thumbnail from '../../../../components/widgets/Thumbnail';
// import AddAgent from './AddAgent';
// import EditAgent from './EditAgent';
import accountMixin from '../../../../mixins/account';

export default {
  components: {
    // AddAgent,
    // EditAgent,
    Thumbnail,
  },
  mixins: [globalConfigMixin, accountMixin],
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
      agentList: 'agents/getAgents',
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
    this.$store.dispatch('agents/get');
  },
  methods: {
    showDetails() {},
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
    openDeletePopup(agent) {
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
.agent-admin {
  table tr,
  table td {
    border: none !important;
  }

  .el-table::before {
    display: none;
  }
}
table thead th {
  text-transform: none;
}
.el-table__header-wrapper {
  table {
    margin: 0 !important;
  }
}
</style>
