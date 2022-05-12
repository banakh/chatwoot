<template>
  <woot-modal :show.sync="show" :on-close="onClose">
    <div class="column content-box">
      <woot-modal-header
        header-title="Add intent"
      />

      <form class="row" @submit.prevent="addAgent()">
        <div class="medium-12 columns">
          <label :class="{ error: $v.agentName.$error }">
            Phrase
            <input
              v-model.trim="agentName"
              type="text"
              :placeholder="$t('AGENT_MGMT.ADD.FORM.NAME.PLACEHOLDER')"
              @input="$v.agentName.$touch"
            />
          </label>
        </div>
        <div class="medium-12 columns">
          <label :class="{ error: $v.agentType.$error }">
            Agent
            <select v-if='agentList.length' v-model="agentEmail">
              <option
                v-for="role in agentList"
                :key="role.name"
                :value="role.id"
              >
                {{ role.name }}
              </option>
            </select>
          </label>
        </div>
        <div class="modal-footer">
          <div class="medium-12 columns">
            <woot-submit-button
              :button-text="$t('AGENT_MGMT.ADD.FORM.SUBMIT')"
              :loading="uiFlags.isCreating"
            />
            <button class="button clear" @click.prevent="onClose">
              Add intent
            </button>
          </div>
        </div>
      </form>
    </div>
  </woot-modal>
</template>

<script>
import { required, minLength, email } from 'vuelidate/lib/validators';
import { mapGetters } from 'vuex';

export default {
  props: {
    onClose: {
      type: Function,
      default: () => {},
    },
  },
  data() {
    return {
      agentName: '',
      agentEmail: '',
      agentType: 'agent',
      vertical: 'bottom',
      horizontal: 'center',
      roles: [
        {
          name: 'administrator',
          label: this.$t('AGENT_MGMT.AGENT_TYPES.ADMINISTRATOR'),
        },
        {
          name: 'agent',
          label: this.$t('AGENT_MGMT.AGENT_TYPES.AGENT'),
        },
      ],
      show: true,
    };
  },
  mounted() {
    this.$store.dispatch('agents/get');
  },
  computed: {
    ...mapGetters({
      agentList: 'agents/getAgents',
      uiFlags: 'agents/getUIFlags',
    }),
  },
  validations: {
    agentName: {
      required,
      minLength: minLength(1),
    },
    agentEmail: {
      required,
      email,
    },
    agentType: {
      required,
    },
  },

  methods: {
    showAlert(message) {
      bus.$emit('newToastMessage', message);
    },
    async addAgent() {
      try {
        await this.$store.dispatch('intent/create', {
          phrase: this.agentName,
          user_id: this.agentEmail,
        });
        this.showAlert('Created');
        this.onClose();
      } catch (error) {
        const {
          response: { data: { error: errorResponse = '' } = {} } = {},
        } = error;
        let errorMessage = '';
        if (error.response.status === 422) {
          errorMessage = this.$t('AGENT_MGMT.ADD.API.EXIST_MESSAGE');
        } else {
          errorMessage = this.$t('AGENT_MGMT.ADD.API.ERROR_MESSAGE');
        }
        this.showAlert(errorResponse || errorMessage);
      }
    },
  },
};
</script>
