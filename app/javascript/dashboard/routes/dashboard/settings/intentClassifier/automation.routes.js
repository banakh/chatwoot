import SettingsContent from '../WrapperCustom';
import Automation from './Index';
import { frontendURL } from '../../../../helper/URLHelper';

export default {
  routes: [
    {
      path: frontendURL('accounts/:accountId/settings/intent-classifier'),
      component: SettingsContent,
      name: 'test',
      props: {
        headerTitle: 'AUTOMATION.HEADER',
        icon: 'automation',
        showNewButton: false,
      },
      children: [
        {
          path: '',
          name: 'automation_wrapper',
          redirect: 'list',
        },
        {
          path: 'list',
          name: 'automation_list',
          component: Automation,
          roles: ['administrator'],
        },
      ],
    },
  ],
};
