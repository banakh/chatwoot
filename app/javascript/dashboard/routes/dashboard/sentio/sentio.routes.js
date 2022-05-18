import { frontendURL } from '../../../helper/URLHelper';
// import intentClassifier from './intentClassifier/agent.routes';
// import SettingsContent from './WrapperCustom';
import intentClassifier from './intentClassifier/Index';
import agentAdmin from './agentAdmin/Index';
import agentAdminShow from './agentAdmin/Show';
import tenantAdmin from './tenantAdmin/Index';
import customerProfile from './customerProfile/Index';
// import AgentHome from '../settings/agents';
// import ContactsView from '../contacts/components/ContactsView';
// import ContactManageView from '../contacts/pages/ContactManageView';
// import store from '../../../store';

export default {
  routes: [
    {
      path: frontendURL('accounts/:accountId/sentio-manager/intent-classifier'),
      name: 'intent_classifier_index',
      roles: ['administrator', 'agent'],
      component: intentClassifier,
    },
    {
      path: frontendURL('accounts/:accountId/sentio-manager/customer-profile'),
      name: 'intent_classifier_index',
      roles: ['administrator', 'agent'],
      component: customerProfile,
    },
    {
      path: frontendURL(
        'accounts/:accountId/sentio-manager/agent-admin/:agentId'
      ),
      name: 'agent_admin_show',
      component: agentAdminShow,
      roles: ['administrator'],
    },
    {
      path: frontendURL('accounts/:accountId/sentio-manager/agent-admin'),
      name: 'agent_admin_index',
      roles: ['administrator', 'agent'],
      component: agentAdmin,
    },
    {
      path: frontendURL('accounts/:accountId/sentio-manager/tenant-admin'),
      name: 'tenant_admin_index',
      roles: ['administrator', 'agent'],
      component: tenantAdmin,
    },
  ],
};
