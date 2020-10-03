<?php

declare(strict_types=1);

namespace App\Controller;

use App\Model\Search;
use App\Model\Review;
class SearchController extends AbstractController
{
    public function indexAction()
    {
        return $this->view->render('search', [
            'movie' => Search::getMultiple('mov_year',$_POST['search'])
        ]);
    }
}
