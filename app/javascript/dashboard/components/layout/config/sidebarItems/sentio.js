import { frontendURL } from '../../../../helper/URLHelper';

const settings = accountId => ({
  parentNav: 'sentio_manager',
  routes: [
    'tenant_admin_index',
    'agent_admin_index',
    'agent_admin_show',
    'intent_classifier_index',
  ],
  menuItems: [
    {
      icon: 'settings',
      label: 'TENANT_ADMIN',
      hasSubMenu: false,
      toState: frontendURL(`accounts/${accountId}/sentio-manager/tenant-admin`),
      toStateName: 'tenant_admin_index',
    },
    {
      icon: 'people',
      label: 'AGENT_ADMIN',
      hasSubMenu: false,
      toState: frontendURL(`accounts/${accountId}/sentio-manager/agent-admin`),
      toStateName: 'agent_admin_index',
    },
    {
      icon: 'bot',
      label: 'BOT_BUILDER',
      hasSubMenu: true,
      toState: frontendURL(`accounts/${accountId}/sentio-manager`),
      children: [
        {
          id: '1',
          label: 'Customer Profile',
          icon: 'text-seating',
          truncateLabel: true,
          simpleIcon: true,
          toState: frontendURL(
            `accounts/${accountId}/sentio-manager/customer-profile`
          ),
        },
        {
          id: '2',
          label: 'Intent Classifier',
          icon: 'settings',
          simpleIcon: true,
          truncateLabel: true,
          toState: frontendURL(
            `accounts/${accountId}/sentio-manager/intent-classifier`
          ),
        },
      ],
    },
  ],
});

export default settings;
