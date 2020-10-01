<?php

namespace App\Controller;

use App\Model\User;

class UserController extends AbstractController
{
    public function loginAction()
    {
        if (!$this->auth->isLoggedIn()) {
            return $this->view->render('login');
        }

        header('Location: /~polaznik13/');
    }

    public function registerAction()
    {
        if (!$this->auth->isLoggedIn()) {
            return $this->view->render('register');
        }

        header('Location: /~polaznik13/');
    }

    public function registerSubmitAction()
    {
        if (!$this->isPost()) {
            // only POST requests are allowed
            header('Location: /~polaznik13/');
            return;
        }

        $requiredKeys = ['first_name', 'last_name', 'email', 'password', 'confirm_password'];
        if (!$this->validateData($_POST, $requiredKeys)) {
            // set error message
            header('Location: /~polaznik13/user/register');
            return;
        }

        if ($_POST['password'] !== $_POST['confirm_password']) {
            // set error message
            header('Location: /~polaznik13/user/register');
            return;
        }

        $user = User::getOne('email', $_POST['email']);

        if ($user->getId()) {
            // user already exists
            header('Location: /~polaznik13/user/register');
            return;
        }
        User::insert([
            'first_name' => $_POST['first_name'] ?? null,
            'last_name' => $_POST['last_name'] ?? null,
            'email' => $_POST['email'],
            'pass' => password_hash($_POST['password'], PASSWORD_DEFAULT),
            'user_type'=>$_POST['user_type'],
        ]);

        header('Location: /~polaznik13/user/login');
    }

    public function loginSubmitAction()
    {
        // only POST requests are allowed
        if (!$this->isPost() || $this->auth->isLoggedIn()) {
            header('Location: /~polaznik13/');
            return;
        }

        $requiredKeys = ['email', 'password'];
        if (!$this->validateData($_POST, $requiredKeys)) {
            // set error message
            header('Location: /~polaznik13/user/login');
            return;
        }

        $user = User::getOne('email', $_POST['email']);

        if (!$user->getId() || !password_verify($_POST['password'], $user->getPassword()) || !$user->getUserType()===3) {
            // set error message
            header('Location: /~polaznik13/user/login');
            return;
        }

        $this->auth->login($user);
        header('Location: /~polaznik13/');
    }

    protected function validateData(array $data, array $keys): bool
    {
        foreach ($keys as $key) {
            $isValueValid = isset($data[$key]) && $data[$key];
            if (!$isValueValid) {
                return false;
            }
        }
        return true;
    }

    public function logoutAction()
    {
        if ($this->auth->isLoggedIn()) {
            $this->auth->logout();
        }

        header('Location: /~polaznik13/');
    }
    public function accountAction()
    {
        if($this->auth->isLoggedIn()){
            return $this->view->render('account');
        }
    }
    public function changeAction()
    {
        if($this->auth->isLoggedIn())
        {
            User::change('pass',$_POST['id'],password_hash($_POST['new_pass'], PASSWORD_DEFAULT));
        }
    }
}
