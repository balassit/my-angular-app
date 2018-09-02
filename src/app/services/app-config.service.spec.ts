import { TestBed, inject } from '@angular/core/testing';

import { AppConfigService } from './app-config.service';

describe('AppConfigService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [AppConfigService]
    });
  });

  it('should be created', inject([AppConfigService], (service: AppConfigService) => {
    expect(service).toBeTruthy();
  }));

  it('should handle missing config files', () => {
    AppConfigService.load('bogus/file.json').catch((err: string) => {
      expect(err).toEqual('Could not load file \'bogus/file.json\': 404');
    });
  });
});
