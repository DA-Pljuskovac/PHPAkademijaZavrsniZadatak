<?php

declare(strict_types=1);

namespace App\Controller;

use App\Model\Review;
use App\Model\Post;
use App\Model\Moviecast;
use App\Model\Up;
use App\Model\Down;
use App\Model\Director;
use App\Model\Genres;
use App\Model\Voted;
use App\Model\Watchlist;
class ReviewController extends AbstractController
{
    public function createAction()
    {
        if (!$this->isPost() || !$this->auth->isLoggedIn()) {
            header('Location: /~polaznik13/');
            return;
        }

        $postContent = $_POST['new_review'] ?? '';

        if (!$postContent) {
            // set error message
            header('Location: /~polaznik13/');
            return;
        }
        if($this->auth->getCurrentUser()->getId()==Review::getOne('user_id',$this->auth->getCurrentUser()->getId()))
        {
            header('Location: /~polaznik13/');
            return;
        }
        Review::insert([
            'rev_name'=>$this->auth->getCurrentUser()->getFirstName().' '.$this->auth->getCurrentUser()->getLastName(),
            'rev_content'=>$postContent,
            'rev_mov_id'=>$_POST['mov_id'],
            'rev_score'=>$_POST['review_rating'],
            'rev_up'=>0,
            'rev_down'=>0,
            'user_type'=>$this->auth->getCurrentUser()->getUser_type(),
            'user_id'=>$this->auth->getCurrentUser()->getId()
        ]);
        header("Location: /~polaznik13/review/details?id={$_POST['mov_id']}");
    }

    public function deleteAction()
    {
        $postId = $_GET['id'] ?? null;
        if (!$postId || !$this->auth->isLoggedIn()) {
            header('Location: /~polaznik13/');
            return;
        }

        $post = Review::getOne('rev_id', $postId);

        if (($post->getUser_id() == $this->auth->getCurrentUser()->getId()) || $this->auth->getCurrentUser()->getUser_type()==3) {
            Review::delete('rev_id', $postId);
        }

        header('Location: /~polaznik13/');
    }
    public function detailsAction()
    {
        $postId=$_GET['id'] ?? null;
        if( !$postId){
            header('Location: /~polaznik13/');
            return;
        }
        return $this->view->render('details',[
            'movie'=>Post::getOne('mov_id',$postId),
            'review'=>Review::getMultiple('rev_mov_id',$postId),
            'actor'=>Moviecast::getMultiple('mov_id',$postId),
            'director'=>Director::getMultiple('mov_id',$postId),
            'movie_genres'=>Genres::getMultiple('mov_id',$postId),
            'movie_watchlist'=>Watchlist::getOne('mov_id',$postId),
            'has_voted'=>Voted::getMultiple('mov_id',$postId)]);
    }
    public function upAction()
    {
        $postId=$_POST['id'] ?? null;
        if (!$postId){
            header('Location: /~polaznik13/');
            return;
        }
        Up::up('rev_up',$postId,1);
        Voted::change('voted',$postId,1);
        Voted::change('rev_id',$postId,$_POST['rev_id']);
        header ("Location: /~polaznik13/review/details?id={$_POST['mov_id']}");
    }
    public function downAction()
    {
        $postId=$_POST['id'] ?? null;
        if (!$postId){
            header('Location: /~polaznik13/');
            return;
        }
        Down::down('rev_down',$postId,1);
        Voted::change('voted',$postId,2);
        Voted::change('rev_id',$postId,$_POST['rev_id']);
        header ("Location: /~polaznik13/review/details?id={$_POST['mov_id']}");
    }
    public function addToAction()
    {
        $postId=$_POST['id'] ?? null;
        if(!$postId){
            header('Location: /~polaznik13/');
            return;
        }
        Watchlist::insert([
           'user_id'=>$this->auth->getCurrentUser()->getId(),
            'mov_id'=>$_POST['mov_id'],
            'mov_title'=>$_POST['mov_title'],
        ]);
        header("Location: /~polaznik13/user/account");
    }
    public function deleteFromAction()
    {
        $postId = $_GET['id'] ?? null;
        if (!$postId || !$this->auth->isLoggedIn()) {
            header('Location: /~polaznik13/');
            return;
        }

        $post = Watchlist::getOne('mov_id', $postId);

        if (($post->getUser_id() == $this->auth->getCurrentUser()->getId())) {
            Watchlist::delete('mov_id', $postId);
        }

        header('Location: /~polaznik13/');
    }
}
