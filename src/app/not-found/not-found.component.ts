import { Component, OnInit } from '@angular/core';
import { Location } from '@angular/common';
import { Router } from '@angular/router';
import { Title, Meta } from '@angular/platform-browser';

@Component({
  selector: 'app-not-found',
  templateUrl: './not-found.component.html',
  styleUrls: ['./not-found.component.css']
})
export class NotFoundComponent implements OnInit {

  constructor(private location: Location, private router: Router, private titleService: Title, private metaService: Meta) { }

  back(): void {
    this.location.back();
  }

  ngOnInit() {
    this.metaService.updateTag({ name: 'title', content: 'Page Not Found | StreamsApps LLC'});
  }

}
