<?php

namespace App\Api\Controller;

use Psr\Log\LoggerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class OrderController extends AbstractController
{
    #[Route('/api/order/{id}', name: 'get_order', methods: ['GET'])]
    public function getOrder(int $id, LoggerInterface $logger): Response
    {
        $logger->info('Order get '. $id);
        return $this->json(['success' => true, 'message' => 'Order is here']);

    }
}
