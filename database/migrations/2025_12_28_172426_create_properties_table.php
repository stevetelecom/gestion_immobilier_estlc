<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('properties', function (Blueprint $table) {
            $table->id();
            $table->foreignId('owner_id')->constrained('users')->onDelete('cascade');
            $table->string('title');
            $table->text('description');
            $table->enum('type', ['appartement', 'maison', 'bureau', 'studio', 'villa', 'terrain']);
            $table->string('address');
            $table->string('city');
            $table->string('country')->default('Cameroun');
            $table->decimal('surface', 10, 2);
            $table->integer('bedrooms')->default(0);
            $table->integer('bathrooms')->default(0);
            $table->decimal('price', 10, 2);
            $table->enum('status', ['disponible', 'loue', 'maintenance', 'indisponible'])->default('disponible');
            $table->boolean('is_furnished')->default(false);
            $table->json('amenities')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('properties');
    }
};
