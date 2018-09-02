import { enableProdMode } from '@angular/core';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { AppModule } from './app/app.module';
import { AppConfigService } from './app/services/app-config.service';
import { IAppConfig } from './app/models/IAppConfig';
import { environment } from './environments/environment';

AppConfigService.load('assets/config.json')
  .then((settings: IAppConfig) => {
    if (settings.env === 'prod' || settings.env === 'preprod') {
      enableProdMode();
    }
    return platformBrowserDynamic().bootstrapModule(AppModule);
  }).catch((err: string) => console.log(err));
