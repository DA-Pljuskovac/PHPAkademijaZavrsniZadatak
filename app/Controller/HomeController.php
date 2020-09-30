<?php

declare(strict_types=1);

namespace App\Controller;

use App\Model\Post;
use App\Model\Review;
class HomeController extends AbstractController
{
    public function indexAction()
    {
        return $this->view->render('home', [
            'movie' => Post::getAll()
        ]);
    }
}
