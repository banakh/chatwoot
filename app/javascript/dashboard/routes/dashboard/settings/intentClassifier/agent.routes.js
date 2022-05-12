import SettingsContent from '../WrapperCustom';
import AgentHome from './Index';
import { frontendURL } from '../../../../helper/URLHelper';

export default {
  routes: [
    {
      path: frontendURL('accounts/:accountId/settings/intent-classifier'),
      component: SettingsContent,
      props: {
        headerTitle: 'Intent Classifier',
        showNewButton: false,
      },
      children: [
        {
          path: '',
          name: 'agents_wrapper',
          redirect: 'list',
        },
        {
          path: 'list',
          name: 'agent_list',
          component: AgentHome,
          roles: ['administrator'],
        },
      ],
    },
  ],
};
