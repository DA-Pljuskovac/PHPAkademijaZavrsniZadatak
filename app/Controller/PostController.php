<?php

declare(strict_types=1);

namespace App\Controller;

use App\Model\Post;

class PostController extends AbstractController
{
    public function createAction()
    {
        if (!$this->isPost() || !$this->auth->isLoggedIn()) {
            header('Location: /~polaznik13/');
            return;
        }

        $postContent = $_POST['new_post'] ?? '';

        if (!$postContent) {
            // set error message
            header('Location: /~polaznik13/');
            return;
        }

        header('Location: /~polaznik13/');
    }
}
