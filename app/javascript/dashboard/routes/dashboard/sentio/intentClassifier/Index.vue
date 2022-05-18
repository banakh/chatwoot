<template>
  <div class="column content-box">
    <h5>Intent Classifier</h5>

    <div class="content-box">
      <h6>Mediaflows</h6>
      <div style="display:flex; flex-direction: column; margin: 20px 0">
        <el-radio v-model="mediaType" label="all">All Mediaflows</el-radio>
        <el-radio v-model="mediaType" label="by">By Mediaflow</el-radio>
      </div>

      <el-tabs v-if="mediaType === 'all'" v-model="activeName">
        <el-tab-pane label="Dialogflow" name="first">
          <el-input
            v-model="input"
            class="search-intent"
            placeholder="Search intent"
            prefix-icon="el-icon-search"
          ></el-input>
          <div
            role="group"
            aria-label="checkbox-group"
            class="el-checkbox-group"
          >
            <el-checkbox
              v-for="intent in intentListDialogflow"
              :key="intent.id"
              :disabled="true"
              @change="() => handleCheckedIntent(intent)"
              v-model="intent.enabled"
            >
              {{ intent.name }}
            </el-checkbox>
          </div>
        </el-tab-pane>
        <el-tab-pane label="Manually added Intents" name="second">
          <div
            role="group"
            aria-label="checkbox-group"
            class="el-checkbox-group"
          >
            <el-checkbox
              v-for="intent in intentListApp"
              :key="intent.id"
              @change="() => handleCheckedIntent(intent)"
              v-model="intent.enabled"
            >
              {{ intent.name }}
            </el-checkbox>
          </div>

          <el-button
            class="add-intent"
            type="primary"
            @click="dialogFormVisible = true"
          >
            Add intent
          </el-button>

          <el-dialog
            width="30%"
            title="Add intent"
            :visible.sync="dialogFormVisible"
          >
            <el-form label-position="top" :model="intentForm">
              <el-form-item label="Name">
                <el-input
                  v-model="intentForm.name"
                  autocomplete="off"
                ></el-input>
              </el-form-item>
              <el-form-item label="Phrases">
                <el-select
                  v-model="intentForm.phrases"
                  multiple
                  filterable
                  allow-create
                  default-first-option
                  placeholder="Add Utterance"
                >
                  <el-option
                    v-for="item in ['']"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="Agent (demo)">
                <el-select
                  v-if="agentList.length"
                  v-model="intentForm.user_id"
                  placeholder="Select"
                >
                  <el-option
                    v-for="role in agentList"
                    :key="role.id"
                    :label="role.name"
                    :value="role.id"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="Utterance">
                <el-select
                  v-model="utterancesValue"
                  multiple
                  filterable
                  allow-create
                  default-first-option
                  placeholder="Add Utterance"
                >
                  <el-option
                    v-for="item in utterances"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  >
                  </el-option>
                </el-select>
              </el-form-item>

              <el-form-item label="Desired action">
                <el-input v-model="form.region" autocomplete="off"></el-input>
              </el-form-item>
            </el-form>
            <el-form label-position="left" :model="form">
              <el-form-item label="Importance level" label-width="150px">
                <el-input-number
                  v-model="num1"
                  label="Importance level"
                  controls-position="right"
                  :min="1"
                  :max="5"
                ></el-input-number>
              </el-form-item>
              <el-form-item label="Urgency level" label-width="150px">
                <el-input-number
                  v-model="num2"
                  label="Urgency level"
                  controls-position="right"
                  :min="1"
                  :max="5"
                ></el-input-number>
              </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
              <el-button @click="dialogFormVisible = false">Cancel</el-button>
              <el-button type="primary" @click="addIntent(intentForm)"
                >Confirm</el-button
              >
            </span>
          </el-dialog>
        </el-tab-pane>
      </el-tabs>

      <el-tabs v-else v-model="byMediaflow">
        <el-tab-pane label="IT Products" name="first">
          <el-tabs v-model="activeName">
            <el-tab-pane label="Prepopulated Intents" name="first">
              <el-input
                v-model="input"
                class="search-intent"
                placeholder="Search intent"
                prefix-icon="el-icon-search"
              ></el-input>
              <el-checkbox-group
                v-model="checkedCities"
                @change="handleCheckedCitiesChange"
              >
                <el-checkbox v-for="city in cities" :key="city" :label="city">
                  {{ city }}
                </el-checkbox>
              </el-checkbox-group>
            </el-tab-pane>
            <el-tab-pane label="Manually added Intents" name="second">
              <el-checkbox-group
                v-model="checkedIntent"
                @change="handleCheckedIntent"
              >
                <el-checkbox v-for="city in intent" :key="city" :label="city">
                  {{ city }}
                </el-checkbox>
              </el-checkbox-group>

              <el-button
                class="add-intent"
                type="primary"
                @click="dialogFormVisible = true"
              >
                Add intent
              </el-button>

              <el-dialog
                width="30%"
                title="Add intent"
                :visible.sync="dialogFormVisible"
              >
                <el-form label-position="top" :model="form">
                  <el-form-item label="Name">
                    <el-input v-model="form.name" autocomplete="off"></el-input>
                  </el-form-item>
                  <el-form-item label="Utterance">
                    <el-select
                      v-model="utterancesValue"
                      multiple
                      filterable
                      allow-create
                      default-first-option
                      placeholder="Add Utterance"
                    >
                      <el-option
                        v-for="item in utterances"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value"
                      >
                      </el-option>
                    </el-select>
                  </el-form-item>

                  <el-form-item label="Desired action">
                    <el-input
                      v-model="form.region"
                      autocomplete="off"
                    ></el-input>
                  </el-form-item>
                </el-form>
                <el-form label-position="left" :model="form">
                  <el-form-item label="Importance level" label-width="150px">
                    <el-input-number
                      v-model="num1"
                      label="Importance level"
                      controls-position="right"
                      :min="1"
                      :max="5"
                    ></el-input-number>
                  </el-form-item>
                  <el-form-item label="Urgency level" label-width="150px">
                    <el-input-number
                      v-model="num2"
                      label="Urgency level"
                      controls-position="right"
                      :min="1"
                      :max="5"
                    ></el-input-number>
                  </el-form-item>
                </el-form>
                <span slot="footer" class="dialog-footer">
                  <el-button @click="dialogFormVisible = false"
                    >Cancel</el-button
                  >
                  <el-button type="primary" @click="addIntent(form)"
                    >Confirm</el-button
                  >
                </span>
              </el-dialog>
            </el-tab-pane>
          </el-tabs>
        </el-tab-pane>
        <el-tab-pane label="Logistics" name="second">
          <el-tabs v-model="activeName">
            <el-tab-pane label="Prepopulated Intents" name="first">
              <el-input
                v-model="input"
                class="search-intent"
                placeholder="Search intent"
                prefix-icon="el-icon-search"
              ></el-input>
              <el-checkbox-group
                v-model="checkedCities"
                @change="handleCheckedCitiesChange"
              >
                <el-checkbox v-for="city in cities" :key="city" :label="city">
                  {{ city }}
                </el-checkbox>
              </el-checkbox-group>
            </el-tab-pane>
            <el-tab-pane label="Manually added Intents" name="second">
              <el-checkbox-group
                v-model="checkedIntent"
                @change="handleCheckedIntent"
              >
                <el-checkbox v-for="city in intent" :key="city" :label="city">
                  {{ city }}
                </el-checkbox>
              </el-checkbox-group>

              <el-button
                class="add-intent"
                type="primary"
                @click="dialogFormVisible = true"
              >
                Add intent
              </el-button>

              <el-dialog
                width="30%"
                title="Add intent"
                :visible.sync="dialogFormVisible"
              >
                <el-form label-position="top" :model="form">
                  <el-form-item label="Name">
                    <el-input v-model="form.name" autocomplete="off"></el-input>
                  </el-form-item>
                  <el-form-item label="Utterance">
                    <el-select
                      v-model="utterancesValue"
                      multiple
                      filterable
                      allow-create
                      default-first-option
                      placeholder="Add Utterance"
                    >
                      <el-option
                        v-for="item in utterances"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value"
                      >
                      </el-option>
                    </el-select>
                  </el-form-item>

                  <el-form-item label="Desired action">
                    <el-input
                      v-model="form.region"
                      autocomplete="off"
                    ></el-input>
                  </el-form-item>
                </el-form>
                <el-form label-position="left" :model="form">
                  <el-form-item label="Importance level" label-width="150px">
                    <el-input-number
                      v-model="num1"
                      label="Importance level"
                      controls-position="right"
                      :min="1"
                      :max="5"
                    ></el-input-number>
                  </el-form-item>
                  <el-form-item label="Urgency level" label-width="150px">
                    <el-input-number
                      v-model="num2"
                      label="Urgency level"
                      controls-position="right"
                      :min="1"
                      :max="5"
                    ></el-input-number>
                  </el-form-item>
                </el-form>
                <span slot="footer" class="dialog-footer">
                  <el-button @click="dialogFormVisible = false"
                    >Cancel</el-button
                  >
                  <el-button type="primary" @click="addIntent(form)"
                    >Confirm</el-button
                  >
                </span>
              </el-dialog>
            </el-tab-pane>
          </el-tabs>
        </el-tab-pane>
      </el-tabs>
    </div>
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
      intents: ['Increase subscription'],
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
      intentForm: {
        name: '',
        user_id: '1',
        phrases: [],
      },
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
      agentList: 'agents/getAgents',
      uiFlags: 'agents/getUIFlags',
      currentUserId: 'getCurrentUserID',
      globalConfig: 'globalConfig/get',
    }),
    intentListApp() {
      return this.intentList.filter(it => {
        return !it.app_id;
      });
    },
    intentListDialogflow() {
      return this.intentList.filter(it => {
        return it.app_id === 'dialogflow';
      });
    },
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
    this.$store.dispatch('agents/get');
  },
  methods: {
    showEditAction(agent) {
      return this.currentUserId !== agent.id;
    },
    async addIntent(form) {
      try {
        await this.$store.dispatch('intent/create', form);
        this.showAlert('Created');
        this.dialogFormVisible = false;
      } catch (error) {}
    },
    // addIntent(form) {
    //   console.log('---', form);
    //   this.intent.push(form.name);
    //   this.checkedIntent.push(form.name);
    //   this.dialogFormVisible = false;
    // },
    handleCheckedCitiesChange(value) {
      let checkedCount = value.length;
      this.checkAll = checkedCount === this.cities.length;
      this.isIndeterminate =
        checkedCount > 0 && checkedCount < this.cities.length;
    },
    async handleCheckedIntent(form) {
      try {
        await this.$store.dispatch('intent/update', form);
        this.showAlert('Updated');
      } catch (error) {}
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
