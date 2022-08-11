<?php

namespace App\Entity;

use ApiPlatform\Core\Annotation\ApiResource;
use App\Repository\GreetingRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: GreetingRepository::class)]
#[ApiResource]
class Greeting
{
    #[ORM\Id]
    #[ORM\GeneratedValue(strategy: "IDENTITY")]
    #[ORM\Column()]
    private ?int $id = null;

    #[ORM\Column]
    private ?\DateTimeImmutable $createdAt = null;

    #[ORM\Column(length: 50)]
    private ?string $name = null;

    #[ORM\Column(length: 50)]
    private ?string $greetee = null;

    #[ORM\Column(nullable: true)]
    private ?int $times = null;

    #[ORM\Column(length: 50, nullable: true)]
    private ?string $newField = null;

    #[ORM\Column(length: 255)]
    private ?string $anotherField = null;

    #[ORM\Column(length: 255)]
    private ?string $newField2 = null;

    #[ORM\Column(length: 255)]
    private ?string $newField3 = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCreatedAt(): ?\DateTimeImmutable
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTimeImmutable $createdAt): self
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getGreetee(): ?string
    {
        return $this->greetee;
    }

    public function setGreetee(string $greetee): self
    {
        $this->greetee = $greetee;

        return $this;
    }

    public function getTimes(): ?int
    {
        return $this->times;
    }

    public function setTimes(?int $times): self
    {
        $this->times = $times;

        return $this;
    }

    public function getNewField(): ?string
    {
        return $this->newField;
    }

    public function setNewField(?string $newField): self
    {
        $this->newField = $newField;

        return $this;
    }

    public function getAnotherField(): ?string
    {
        return $this->anotherField;
    }

    public function setAnotherField(string $anotherField): self
    {
        $this->anotherField = $anotherField;

        return $this;
    }

    public function getNewField2(): ?string
    {
        return $this->newField2;
    }

    public function setNewField2(string $newField2): self
    {
        $this->newField2 = $newField2;

        return $this;
    }

    public function getNewField3(): ?string
    {
        return $this->newField3;
    }

    public function setNewField3(string $newField3): self
    {
        $this->newField3 = $newField3;

        return $this;
    }
}
