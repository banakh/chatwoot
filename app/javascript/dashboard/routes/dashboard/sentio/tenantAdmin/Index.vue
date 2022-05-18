<template>
  <div class="tenant-admin column content-box">
    <h5>Tenant Admin</h5>

    <div class="content-box">
      <h6>Skills</h6>
      <el-table
        size="mini"
        :select-on-indeterminate="false"
        :data="tableData"
        style="width: 900px"
      >
        <el-table-column label="ID" prop="id" width="100"></el-table-column>
        <el-table-column label="Skills">
          <template slot-scope="scope">
            <el-input
              @input="editRow(scope.row, true)"
              placeholder="Skill name"
              v-model="scope.row.name"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column label="Routing weight">
          <template slot-scope="scope">
            <el-input-number
              v-model="scope.row.routingWeight"
              controls-position="right"
              :min="1"
              @change="editRow(scope.row, true)"
              :max="5"
            ></el-input-number>
          </template>
        </el-table-column>
        <el-table-column>
          <template slot="header" slot-scope="scope">
            <el-popover
              placement="top-start"
              width="200"
              trigger="hover"
              content="this is content, this is content, this is content"
            >
              <span slot="reference">
                Thresholds, sec
                <i class="el-icon-info"></i>
              </span>
            </el-popover>
          </template>
          <template slot-scope="scope">
            <el-input-number
              @change="editRow(scope.row, true)"
              v-model="scope.row.threshold"
              controls-position="right"
              :min="1"
              :max="5"
            ></el-input-number>
          </template>
        </el-table-column>

        <el-table-column
          label-class-name="text-center"
          align="center"
          label="Self-administered"
        >
          <template slot-scope="scope">
            <el-checkbox
              @change="editRow(scope.row, true)"
              v-model="scope.row.selfAdministered"
            />
          </template>
        </el-table-column>
        <el-table-column>
          <template slot-scope="scope">
            <el-button
              type="text"
              size="small"
              v-if="scope.row.edit"
              @click="editRow(scope.row, false)"
              >Save</el-button
            >
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div class="content-box">
      <h6>Mediaflows</h6>

      <el-table
        size="mini"
        :select-on-indeterminate="false"
        :data="mediaflowData"
        style="width: 900px"
      >
        <el-table-column label="Mediaflows" prop="name"></el-table-column>
        <el-table-column width="200">
          <template slot="header" slot-scope="scope">
            <el-popover
              placement="top-start"
              width="200"
              trigger="hover"
              content="this is content, this is content, this is content"
            >
              <span slot="reference">
                SLA, sec
                <i class="el-icon-info"></i>
              </span>
            </el-popover>
          </template>
          <template slot-scope="scope">
            <el-input-number
              @change="editRow(scope.row, true)"
              v-model="scope.row.sla"
              controls-position="right"
              :min="1"
              :max="5"
            ></el-input-number>
          </template>
        </el-table-column>
        <el-table-column width="200">
          <template slot="header" slot-scope="scope">
            TRA, sec
            <el-popover
              placement="top-start"
              width="200"
              trigger="hover"
              content="Threshold of reserved agents 0 - 120 seconds"
            >
              <i slot="reference" class="el-icon-info"></i>
            </el-popover>
          </template>
          <template slot-scope="scope">
            <el-input-number
              @change="editRow(scope.row, true)"
              v-model="scope.row.tra"
              controls-position="right"
              :min="1"
              :max="120"
            ></el-input-number>
          </template>
        </el-table-column>
        <el-table-column>
          <template slot-scope="scope">
            <el-button
              type="text"
              size="small"
              v-if="scope.row.edit"
              @click="editRow(scope.row, false)"
              >Save</el-button
            >
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>
<script>
import { mapGetters } from 'vuex';
import Vue from 'vue';
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
      mediaflowData: [
        {
          name: 'Airfare reservation',
          sla: 2,
          tra: 4,
        },
        {
          name: 'Lost Luggage',
          sla: 1,
          tra: 3,
        },
        {
          name: 'Price',
          sla: 4,
          tra: 100,
        },
      ],
      tableData: [
        {
          id: '001',
          name: 'English',
          routingWeight: 2,
          threshold: 3,
          selfAdministered: true,
        },
        {
          id: '002',
          name: 'Dutch',
          routingWeight: 2,
          threshold: 3,
          selfAdministered: false,
        },
        {
          id: '003',
          name: 'IT Product',
          routingWeight: 4,
          threshold: 3,
          selfAdministered: false,
        },
        {
          id: '004',
          name: 'Audio & Video',
          routingWeight: 2,
          threshold: 3,
          selfAdministered: true,
        },
        {
          id: '005',
          name: 'Logistics',
          routingWeight: 2,
          threshold: 3,
          selfAdministered: true,
        },
        {
          id: '006',
          name: '',
          routingWeight: 0,
          threshold: 0,
          selfAdministered: false,
        },
      ],
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
    editRow(row, state) {
      Vue.set(row, 'edit', state);
    },
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
.tenant-admin {
  h4 {
    //text-align: center;
  }
  h6 {
    padding-bottom: 10px;
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

  .el-input {
    input {
      margin: 0 !important;
    }

    width: 100% !important;
    margin: 0 !important;
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

  table thead th {
    font-weight: 600;
    color: #383636;
    text-transform: none;
  }

  table tr,
  table td {
    border: none !important;
  }

  .el-input-number {
    width: 140px;
  }

  .el-table::before {
    display: none;
  }

  .el-select {
    width: 100%;
  }

  input[readonly] {
    background-color: white !important;
  }
}
</style>
