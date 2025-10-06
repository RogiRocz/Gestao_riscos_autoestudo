import Vue from 'vue';
import Vuetify from 'vuetify/lib';
import pt from 'vuetify/es5/locale/pt';
import '@mdi/font/css/materialdesignicons.css'

Vue.use(Vuetify);

export default new Vuetify({
  theme: {
    themes: {
      light: {
        primary: '#510E80',
        secondary: '#8217CC',
        accent: '#C169FF',
        error: '#F24130',
        info: '#0540F2',
        success: '#02732A',
        warning: '#f2b204'
      }
    },
  },
    lang: {
      locales: { pt },
      current: 'pt',
    },
  icons: {
    iconfont: 'mdi', // default - only for display purposes
  },
});
