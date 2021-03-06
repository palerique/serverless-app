import {Component, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {Title} from '@angular/platform-browser';
import 'rxjs/add/operator/delay';

import {AuthenticationService} from '../../core/services/auth.service';
import {NotificationService} from '../../core/services/notification.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  loginForm!: FormGroup;
  loading = false;

  constructor(private router: Router,
              private titleService: Title,
              private notificationService: NotificationService,
              private authenticationService: AuthenticationService) {
  }

  ngOnInit() {
    this.titleService.setTitle('angular-material-template - Login');
    this.authenticationService.logout();
    this.createForm();
  }

  login() {
    const email = this.loginForm.get('email')?.value;
    const password = this.loginForm.get('password')?.value;
    const rememberMe = this.loginForm.get('rememberMe')?.value;

    this.loading = false;
    this.authenticationService
      .login(email.toLowerCase(), password)
      .subscribe(
        data => {
          if (rememberMe) {
            localStorage.setItem('savedUserEmail', email);
          } else {
            localStorage.removeItem('savedUserEmail');
          }
          this.router.navigate(['/']);
        },
        error => {
          this.notificationService.openSnackBar(error.error);
          this.loading = false;
        }
      );
  }

  resetPassword() {
    this.router.navigate(['/auth/password-reset-request']);
  }

  private createForm() {
    const savedUserEmail = localStorage.getItem('savedUserEmail');

    this.loginForm = new FormGroup({
      email: new FormControl(savedUserEmail, [Validators.required, Validators.email]),
      password: new FormControl('', Validators.required),
      rememberMe: new FormControl(savedUserEmail !== null)
    });
  }
}
