<?php

declare(strict_types=1);

namespace App\Controller;

use App\Model\Post;
use App\Model\Review;
use App\Model\Search;
class HomeController extends AbstractController
{
    public function indexAction()
    {
        return $this->view->render('home', [
            'movie' => Post::getAll('mov_dt_rel',[0,10])
        ]);
    }
}
