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
            'movie' => Search::search('mov_title',$_POST['search'],'mov_dt_rel',[0,10])
        ]);
    }
}
